module Ckeditor::ApplicationHelper
  def assets_pipeline_enabled?
    if Gem::Version.new(::Rails.version.to_s) >= Gem::Version.new('4.0.0')
      defined?(Sprockets::Rails)
    elsif Gem::Version.new(::Rails.version.to_s) >= Gem::Version.new('3.0.0')
      Rails.application.config.assets.enabled
    else
      false
    end
  end
  #convert like down
  # => "Once upon a time in a world..."
  def truncate(text, options = {}, &block)
    if text
      length  = options.fetch(:length, 30)

      content = text.truncate(length, options)
      content = options[:escape] == false ? content.html_safe : ERB::Util.html_escape(content)
      content << capture(&block) if block_given? && text.length > length
      content
    end
  end
end