# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def add_stylesheets(*args)
    @stylesheets = (@stylesheets ||= []) + args
  end

  def add_stylesheet_link_tag
    unless @stylesheets.nil? || @stylesheets.empty?
      stylesheet_link_tag(*@stylesheets)
    end
  end

  def add_javascripts(*args)
    @javascripts = (@javascripts ||= []) + args
  end

  def add_javascript_include_tag
    unless @javascripts.nil? || @javascripts.empty?
      javascript_include_tag(*@javascripts)
    end
  end

  def need_clipboard_assets
    # We want to do this only once.
    unless @need_clipboard_assets == true
      @need_clipboard_assets = true
      add_javascripts 'ZeroClipboard'
    end
  end

  def add_clipboard_assets
    if @need_clipboard_assets == true    
      @need_clipboard_assets = false
      javascript_tag do
        "ZeroClipboard.setMoviePath('#{compute_public_path('ZeroClipboard.swf', 'assets')}');"
      end
    end
  end

  def spry_json_dataset(name, url, options = { })
    add_javascripts("spry/SpryData",
                    "spry/SpryDOMUtils",
                    "spry/SpryJSONDataSet")
    if options.has_key?('headers')
      headers = options('headers')
      unless headers.has_key?('Content-type')
        headers['Accept'] = 'application/json'
      end
    else
      options['headers'] = { 'Accept' => 'application/json' }
    end
    s = "var #{name} = new Spry.Data.JSONDataSet(#{url.to_json}, #{options.to_json});"
    spry_datasets << s
  end

  def spry_datasets
    @spry_datasets ||= []
  end

  def add_spry_datasets
    unless spry_datasets.empty?
      javascript_tag do
        spry_datasets.join("\n")
      end
    end
  end
end
