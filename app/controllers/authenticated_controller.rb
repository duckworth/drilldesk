# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_paper_trail_whodunnit
  # before_action :set_current_tenant
end
