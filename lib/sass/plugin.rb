require 'sass'
require 'sass/plugin/base'

module Sass
  # This module handles the compilation of Sass files.
  # It provides global options and checks whether CSS files
  # need to be updated.
  #
  # This module is used as the primary interface with Sass
  # when it's used as a plugin for various frameworks.
  # All Rack-enabled frameworks are supported out of the box.
  # The plugin is {file:SASS_REFERENCE.md#rails_merb_plugin automatically activated for Rails and Merb}.
  # Other frameworks must enable it explicitly; see {Sass::Plugin::Rack}.
  #
  # This module has a large set of callbacks available
  # to allow users to run code (such as logging) when certain things happen.
  # All callback methods are of the form `on_#{name}`,
  # and they all take a block that's called when the given action occurs.
  #
  # @example Using a callback
  # Sass::Plugin.on_updating_stylesheet do |template, css|
  #   puts "Compiling #{template} to #{css}"
  # end
  # Sass::Plugin.update_stylesheets
  #   #=> Compiling app/sass/screen.sass to public/stylesheets/screen.css
  #   #=> Compiling app/sass/print.sass to public/stylesheets/print.css
  #   #=> Compiling app/sass/ie.sass to public/stylesheets/ie.css
  module Plugin
    extend self
    
    def instance
      @instance ||= Base.new
    end
    
    # Delegate callbacks to plugin instance
    extend Forwardable
    
    def_delegators :instance,
      :on_updating_stylesheets, :on_updating_stylesheet, :on_not_updating_stylesheet,
      :on_compilation_error, :on_creating_directory, :on_template_modified, :on_template_created,
      :on_template_deleted, :on_deleting_css, :checked_for_updates, :options, :options=,
      :engine_options, :check_for_updates, :update_stylesheets, :watch
  end
end

require 'sass/plugin/rails' if defined?(ActionController)
require 'sass/plugin/merb'  if defined?(Merb::Plugins)
