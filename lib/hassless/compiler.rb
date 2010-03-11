require "less"

module Hassless
  class Compiler
    def source(path = "")
      @source ||= File.join("app", "stylesheets")
      File.join(@source, path)
    end

    def destination(path = "")
      @destination ||= File.join("tmp", "hassless", "stylesheets")
      File.join(@destination, path.sub(/(le?|c)ss$/, "css"))
    end

    def stylesheets
      Dir[File.join(destination, "**", "*.css")].map { |css| "/stylesheets/" + css.gsub(destination, "") }
    end

    def generate(template)
      source = source(template)
      destination = destination(template)

      if mtime(destination) < mtime(source, :imports => true)
        FileUtils.mkdir_p File.dirname(destination)
        File.open(destination, "w"){|f| f.write compile(source) }
      end
    end

    def run
      Dir[File.join(Rails.root, source, "**", "*.{css,less,lss}")].reject { |path| File.basename(path) =~ /^_/ }.each do |path|
        generate(path.sub(File.join(Rails.root, source), ""))
      end
    end

  protected

    def compile(file)
      File.open(file){ |f| Less::Engine.new(f) }.to_css
    rescue Exception => e
      e.message << "\nFrom #{file}"
      raise e
    end

    def mtime(file, options = {:imports => false})
      return 0 unless File.file?(file)

      mtimes = [File.mtime(file).to_i]

      if options[:imports]
        File.readlines(file).each do |line|
          if line =~ /^\s*@import ['"]([^'"]+)/
            imported = File.join(File.dirname(file), $1)
            mtimes << if imported =~ /\.le?ss$/ # complete path given?
              mtime(imported)
            else # we need to add .less or .lss
              [mtime("#{imported}.less"), mtime("#{imported}.lss")].max
            end
          end
        end
      end

      mtimes.max
    end
  end
end