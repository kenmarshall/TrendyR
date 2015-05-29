SimpleNavigation::Configuration.run do |navigation|
  navigation.autogenerate_item_ids = false
  navigation.auto_highlight = false

  navigation.name_generator = proc { |name, item|
    (icon = item.html_options[:icon]) ? content_tag(:i, '', class: icon) + name : name
  }

  navigation.items do |menu|
    menu.item :booking, 'Booking Invitation', '#', icon: 'icon-invitation', if: proc { current_user.role?(:artist) }
    menu.item :settings, 'Profile Settings', '#', icon: 'icon-settings'
    menu.item :messages, 'Messages', '#', icon: 'icon-mes'
    menu.item :payments, 'Payments', '#', icon: 'icon-pay'
    menu.item :logout, 'Log Out', destroy_user_session_path, icon: 'icon-logOut'

    menu.dom_attributes = { class: 'dropdown-menu userInform', role: 'menu', 'aria-labelledby' => 'dLabel' }
  end
end
