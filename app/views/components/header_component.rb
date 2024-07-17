# frozen_string_literal: true

class HeaderComponent < ApplicationComponent
  def view_template
    h1 { "Header" }
    p { "Find me in app/views/components/header_component.rb" }
  end
end
