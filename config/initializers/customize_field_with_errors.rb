# frozen_string_literal: true

ActionView::Base.field_error_proc = proc do |html_tag, _instance_tag|
  html = %(<span class="field_with_errors">#{html_tag}</span>).html_safe
end
