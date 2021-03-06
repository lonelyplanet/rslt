# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'rslt'
  s.version = '2.1.1'

  s.required_rubygems_version = Gem::Requirement.new('>= 2.2.0') if s.respond_to? :required_rubygems_version=
  s.authors = ['Daniel Heath']
  s.date = '2012-04-05'
  s.description = 'I had a lot of XML transformation to do and the requirements kept changing, so I sat down and wrote something that was easy to modify.'
  s.email = ['daniel.r.heath@gmail.com']
  s.extra_rdoc_files = [
    'README.md',
    'TODO'
  ]
  s.files = [
    '.travis.yml',
    'Gemfile',
    'Gemfile.lock',
    'History.txt',
    'PostInstall.txt',
    'README.md',
    'TODO',
    'lib/rslt.rb',
    'lib/rslt/element_wrapper.rb',
    'lib/rslt/rule.rb',
    'lib/rslt/stylesheet.rb',
    'rdoc/RSLT.html',
    'rdoc/RSLT/ElementWrapper.html',
    'rdoc/RSLT/Rule.html',
    'rdoc/RSLT/Stylesheet.html',
    'rdoc/created.rid',
    'rdoc/images/add.png',
    'rdoc/images/brick.png',
    'rdoc/images/brick_link.png',
    'rdoc/images/bug.png',
    'rdoc/images/bullet_black.png',
    'rdoc/images/bullet_toggle_minus.png',
    'rdoc/images/bullet_toggle_plus.png',
    'rdoc/images/date.png',
    'rdoc/images/delete.png',
    'rdoc/images/find.png',
    'rdoc/images/loadingAnimation.gif',
    'rdoc/images/macFFBgHack.png',
    'rdoc/images/package.png',
    'rdoc/images/page_green.png',
    'rdoc/images/page_white_text.png',
    'rdoc/images/page_white_width.png',
    'rdoc/images/plugin.png',
    'rdoc/images/ruby.png',
    'rdoc/images/tag_blue.png',
    'rdoc/images/tag_green.png',
    'rdoc/images/transparent.png',
    'rdoc/images/wrench.png',
    'rdoc/images/wrench_orange.png',
    'rdoc/images/zoom.png',
    'rdoc/index.html',
    'rdoc/js/darkfish.js',
    'rdoc/js/jquery.js',
    'rdoc/js/navigation.js',
    'rdoc/js/search.js',
    'rdoc/js/search_index.js',
    'rdoc/js/searcher.js',
    'rdoc/rdoc.css',
    'rdoc/table_of_contents.html',
    'rslt.gemspec',
    'script/console',
    'script/destroy',
    'script/generate',
    'spec/element_wrapper_spec.rb',
    'spec/excesselt_spec.rb',
    'spec/spec_helper.rb',
    'spec/support/matchers/dom_matcher.rb',
    'tasks/rspec.rake'
  ]
  s.homepage = 'http://www.github.com/danielheath/rslt'
  s.rdoc_options = ['--charset=UTF-8', '-mREADME.md']
  s.require_paths = ['lib']
  s.required_ruby_version = Gem::Requirement.new('>= 2.4')
  s.summary = 'Helps you to transform XML without using XSLT.'

  if s.respond_to? :specification_version
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0')
      s.add_runtime_dependency('builder', ['~> 3'])
      s.add_runtime_dependency('nokogiri', ['~> 1'])
    else
      raise "Old Gem::Version: must be > 1.2.0 (is #{Gem::VERSION})"
    end
  else
    raise "Old Gem::Specification: doesn't respond to `#specification_version`!"
  end
end
