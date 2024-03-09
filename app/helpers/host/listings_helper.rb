module Host::ListingsHelper

def render_partial_with_address(show_address)
    render 'host/listings/_form', listing: @listing, show_address: show_address
end
    
end
