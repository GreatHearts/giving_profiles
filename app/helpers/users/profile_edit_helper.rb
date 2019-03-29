module Users::ProfileEditHelper
  def render_first_donation_bar(donations_by_causes:)
    cause, percent = donations_by_causes[0]
    render_donation_bar(cause: cause, percent: percent, highest: true)
  end

  def render_remaining_donation_bars(donations_by_causes:)
    donations_by_causes[1..-1].each do |cause, percent|
      concat(render_donation_bar(cause: cause, percent: percent))
    end
  end

  def render_donation_bar(cause:, percent:, highest: false)
    render "users/profile_edit/donation_bar", cause: cause, percent: percent, highest: highest
  end
end