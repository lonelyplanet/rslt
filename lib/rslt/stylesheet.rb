# frozen_string_literal: true

begin
  require 'active_support/core_ext/hash/except'
rescue StandardError
  nil
end
require 'builder'

module RSLT
  class Stylesheet
    attr_reader :builder, :errors

    def self.transform(xml)
      new.transform(xml)
    end

    def initialize(options = {})
      @builder = options[:builder] || Builder::XmlMarkup.new
      @helper_modules = options[:helper_modules] || []
      @helper_module_sets = [@helper_modules.dup]
      @errors = options[:errors] || []
      @within = []
      @safe = false
    end

    # Pass in a string or a Nokogiri Node or Document.
    def transform(xml)
      xml = xml.root if xml.is_a? Nokogiri::XML::Document
      xml = Nokogiri::XML(xml, nil, nil, Nokogiri::XML::ParseOptions.new).root unless xml.is_a? Nokogiri::XML::Node
      @document = xml.document
      generate_element(xml)
    end

    def generate_element(element)
      return '' if element.instance_of? Nokogiri::XML::Comment

      rule = rule_for(element)
      raise "Attempted to generate #{name} with parents #{parents.inspect} but no rule was found." unless rule

      rule.generate(builder)
    end

    private

    def rule_for(element)
      # Look up the rule that is used to render this.
      # Should fold into stylesheet.rules (collection) .find(:matches?, element)
      # TODO: Patch enumerable#find etc to take a plain symbol and some arguments?
      current_rule = all_rules.find { |rule| rule.matches? element, @document }

      current_rule || raise([
        'There is no style defined to handle this element.',
        "CSS Path: '#{element.css_path}'",
        "Xpath: '#{element.path}'",
        "Context: '#{element.ancestors.map(&:name).reverse.join(', ')}'"
      ].join("\n"))
    end

    def helper(*mods, &block)
      @safe = false
      @helper_modules.push(mods).flatten!
      block.call
      @helper_modules -= [mods].flatten
    end

    def safe_helper(*mods)
      @safe = true
      @helper_module_sets.push mods
      yield
      @helper_module_sets.pop
    end

    def within(selector)
      @within.push(selector)
      yield
      @within.pop
    end

    def selector_for_current_within
      @within.map { |e| e + ' ' }.join('')
    end

    def render_helpers
      if @safe
        @helper_module_sets.flatten
      else
        @helper_modules
      end
    end

    def render(selector, opts = {}, &block)
      raise "Neither a block nor a :with option were provided for '#{selector}'" unless opts[:with] || block

      mappings << Rule.new(self, selector_for_current_within + selector, render_helpers) do
        if opts[:with]
          if method(opts[:with]).arity.zero?
            send(opts[:with])
          else
            send(opts[:with], opts.except(:with))
          end
        else
          instance_eval(&block)
        end
      end
    end

    def mappings
      @mappings ||= []
    end

    def all_rules
      unless @rules_generated
        rules # Generates the mappings
        @rules_generated = true
      end
      mappings
    end
  end
end
