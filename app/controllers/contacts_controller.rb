class ContactsController < ApplicationController
  def index
    @contacts = request.env['omnicontacts.contacts']
  end
end
