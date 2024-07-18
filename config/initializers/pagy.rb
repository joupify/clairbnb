# Optionally override some pagy default with your own in the pagy initializer

require 'pagy/extras/bootstrap'
require 'pagy/extras/bulma'

Pagy::DEFAULT[:items] = 12 # items per page

# Better user experience handled automatically
require 'pagy/extras/overflow'
Pagy::DEFAULT[:overflow] = :empty_page
