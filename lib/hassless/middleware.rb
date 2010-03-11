gem 'rack'

module Hassless
  class Middleware
    def initialize(app)
      @app = app
      run if Rails.env == "production"
    end

    def call(env)
      run if Rails.env == "development"
      static.call(env)
    end

  protected

    def compiler
      @compiler ||= Hassless::Compiler.new
      @compiler
    end

    def static
      Rack::Static.new(@app, :urls => compiler.stylesheets, :root => File.join(compiler.destination, ".."))
    end

    def run
      compiler.run
    end
  end
end