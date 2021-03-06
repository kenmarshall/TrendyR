module BaseHelper
  ACCESS = {
    public: {
      artist: [:home, :gigs, :releases, :events, :calendar, :press_kit, :photos, :music, :videos],
      venue: [:home, :gigs, :events, :calendar, :gallery, :photos, :location],
      producer: [:home, :artists, :releases, :awards, :location],
      manager: [:home, :artists, :calendar, :location, :events],
      label: [:home, :artists, :releases, :calendar, :awards, :videos, :location, :events]
    }
  }

  ACCESS.keys.each do |type|
    ACCESS.values.map(&:values).flatten.uniq.each do |menu|
      define_method("show_#{type}_#{menu}?") do |profile|
        role = profile.user.role.name.underscore.to_sym
        ACCESS[type][role].include?(menu)
      end
    end
  end

  def distance_of_time_in(unit = :hours, from: Time.now, to: Time.now)
    ((to - from) / 1.send(unit)).round
  end

  def render_empty(name_sym)
    content_tag(:p, "No #{name_sym.downcase}", class: 'emptyBlock m-t20')
  end

  def container_class
    'message_list' if controller_name == 'conversations' && action_name == 'show'
  end
end
