module LambdaLayerCake
  class RakeHelper
    include Rake::DSL

    attr_reader :root
    
    def initialize(root)
      @root = root
    end

    def docker_build_definitions!
      desc "Build Docker Image"
      task :build do
        dockerfile_path = File.expand_path(__dir__ + "/../../templates/Dockerfile")

        raise "Must specify a repository in moonbase_alpha.yml" if repository.blank?

        tag = "#{repository}:#{build_version}"

        cmd = %W{docker build -f #{dockerfile_path} 
          --build-arg RUNTIME_VERSION=#{RUBY_VERSION} 
          --build-arg BLDTIME_PKGS=#{config.build_packages.join(" ")}
          --build-arg COMPILE_ASSETS=#{config.compile_assets.to_s}
          -t #{tag}
          #{root}}
        system(*cmd) or raise 
      end

      desc "Output the last version built"
      task :latest_tag do
        puts latest_tag
      end

      desc "Output the image name for the latest build"
      task :latest_image do
        puts "#{repository}:#{latest_tag}"
      end
    end

    def config
      Rails.configuration.moonbase_alpha
    end

    def repository
      config.repository
    end
    
    def build_version
      @build_version ||= begin
        t = Time.now
        "build-#{t.strftime("%Y-%m-%d-%H-%M-%S")}"
      end
    end

    def latest_tag
      @latest_tag ||= begin
        cmd = %W{ 
          docker image list
          --format {{.Tag}}
          #{repository}
        }

        IO.popen(cmd) do |versions|
          versions.readlines.select {|v| v =~ /\Abuild-/ }.sort.last
        end
      end
    end
  end
end