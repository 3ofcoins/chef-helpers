require 'chef/recipe'
require 'chef/resource/file'

module ChefHelpers
  # Provides means for checking whether a template or cookbook file
  # exist in a recipe, or directly in a resource definition.
  module HasSource
    # Checks for existence of a cookbook file or template source in a cookbook.
    # @param [String] source name of the desired template or cookbook file source
    # @param [Symbol] segment `:files` or `:templates`
    # @param [String, nil] cookbook to look in, defaults to current cookbook
    # @return [String, nil] full path to the source or `nil` if it doesn't exist
    # @example
    #   has_source?("foo.erb", :templates)
    #   has_source?("bar.conf", :files, "a_cookbook")
    def has_source?(source, segment, cookbook=nil)
      cookbook ||= cookbook_name
      begin
        run_context.cookbook_collection[cookbook].
          preferred_filename_on_disk_location(run_context.node, segment, source)
      rescue Chef::Exceptions::FileNotFound
        nil
      end
    end

    # Checks for existence of a template source in a cookbook.
    # @param [String] tmpl name of the template source
    # @param [String,nil] cookbook cookbook to look in, defaults to current cookbook
    # @return [String,nil] full path to the template source or `nil`
    # @see #has_source?
    def has_template?(tmpl, cookbook=nil)
      has_source?(tmpl, :templates, cookbook)
    end

    # Checks for existence of a cookbook file in a cookbook.
    # @param [String] cbf name of the cookbook file
    # @param [String,nil] cookbook cookbook to look in, defaults to current cookbook
    # @return [String,nil] full path to the template source or `nil`
    # @see #has_source?
    def has_cookbook_file?(cbf, cookbook=nil)
      has_source?(tmpl, :files, cookbook)
    end

    # For a list of sources, returns first source that exist
    # @param [Array<String>] sources list of source (template source
    #     or cookbook file) names to look for. Source name can include
    #     a cookbook name, e.g. `"mysql::my.cnf.erb"`
    #
    #     Last parameter can be a `:templates` or `:files` keword, to
    #     indicate what kind of source to look for. If it is ommitted,
    #     and method is called in a `template` or `cookbook_file`
    #     resource block, it is automatically guessed; otherwise,
    #     `RuntimeError` is raised.
    def try_sources(*sources)
      segment =
        if sources.last.is_a?(Symbol)
          sources.pop
        else
          case self
          when Chef::Resource::Template
            :templates
          when Chef::Resource::CookbookFile
            :files
          else
            raise RuntimeError, "Please provide :templates or :files as last argument"
          end
        end
      sources.find do |source|
        if source =~ /::/
          ckbk, src = $`, $'
        else
          ckbk, src = cookbook_name, source
        end
        has_source?(src, segment, ckbk)
      end
    end

    # Return the first template source off the list that exists.
    # @see #try_sources
    def try_templates(*templates)
      try_sources(templates, :templates)
    end

    # Return the first cookbook file off the list that exists.
    # @see #try_sources
    def try_files(*files)
      try_sources(files, :files)
    end
  end
end

class Chef::Recipe
  include ChefHelpers::HasSource
end

class Chef::Resource::File
  include ChefHelpers::HasSource
end
