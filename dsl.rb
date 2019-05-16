=begin
react-component-generator

Author: sadano.katsuya <sadafield@gmail.com>
=end
require 'erb'
require 'fileutils'

class String
    def to_kebab
      self.gsub(/([A-Z]+)([A-Z][a-z])/, '\1-\2')
          .gsub(/([a-z\d])([A-Z])/, '\1-\2')
          .downcase
    end
end

$url_path = []

class Component
    attr_reader :name, :js_name, :class_name, :children, :htmltag
    def initialize(name, type='component')
        @name = name.slice(0).upcase + name.slice(1..-1)
        @js_name = name.slice(0).downcase + name.slice(1..-1)
        @class_name = name.to_kebab
        @type = type
        @children = []
    end

    def child(name)
        @children << Component.new(name)
    end

    def to_s
        template = ERB.new(File.read('template_' + @type + '.erb'), nil, '-')
        return template.result(binding)
    end

    def get_dir_path
        return './results/' + @type + 's/' + get_url_path
    end

    def get_file_name
        return @js_name + '.js'
    end

    def save
        @children.each do |child|
            child.save
        end
        dir_path = get_dir_path
        FileUtils.mkdir_p(dir_path) unless FileTest.exist?(dir_path)
        File.open(dir_path + get_file_name, 'w') do |f| 
            f.puts to_s
        end
    end
end

class Container < Component
    attr_reader :origin, :name, :js_name, :class_name, :children
    def initialize(name)
        super(name, 'container')
    end

    def get_dir_path
        return './results/' + @type + 's/' + get_short_path
    end
end

def url(url_path)
    $url_path = url_path
end

def get_short_path
    path_elements = $url_path.dup
    path_elements.pop
    path_string = ''
    path_elements.each do |element|
       path_string = path_string + element + '/'
    end
    return path_string
end

def get_url_path
    path_string = ''
    $url_path.each do |element|
       path_string = path_string + element + '/'
    end
    return path_string
end

def get_dot_path
    path_string = ''
    $url_path.each do |element|
       path_string = path_string + element + '.'
    end
    return path_string
end

def container(name, &block)
    obj = Container.new(name)
    obj.instance_eval(&block)
    obj.save
end

def component(name, &block)
    obj = Component.new(name)
    obj.instance_eval(&block)
    obj.save
end

# load DSL
load "#{ARGV[0]}"