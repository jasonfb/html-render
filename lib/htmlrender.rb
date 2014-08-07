module HtmlRender
  def render_html_content(*args, &block)
    temp_render_args = HtmlRender._normalized_args(*args, &block)
    temp_render_args[:formats] ||= []
    temp_render_args[:formats] += [:html] unless temp_render_args[:formats].include?(:html)

    # declare so below reference is not block-local
    content = ""

    _render_with_format :html do
      content = render_to_string(temp_render_args).html_safe
    end
    content
  end
  
  def _render_with_format(format, &block)
    old_formats = formats
    self.formats = [format]
    block.call
    self.formats = old_formats
    nil
  end  
  
  class HtmlRender
    def self._normalized_args(action=nil, options={}, &blk) #:nodoc:
      case action
      when NilClass
      when Hash
        options = action
      when String, Symbol
        action = action.to_s
        key = action.include?(?/) ? :file : :action
        options[key] = action
      else
        options[:partial] = action
      end

      options[:update] = blk if block_given?

      options
    end    
  end
end
