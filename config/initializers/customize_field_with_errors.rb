ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  html = %(<span class="field_with_errors">#{html_tag}</span>).html_safe
end
