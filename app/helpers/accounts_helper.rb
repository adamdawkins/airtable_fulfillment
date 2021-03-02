module AccountsHelper
  def account_avatar(account, options = {})
    size = options[:size] || 48
    classes = options[:class]

    if account.personal? && account.owner_id == current_user&.id
      image_tag(
        avatar_url_for(account.users.first, options),
        class: classes,
        alt: account.name
      )

    elsif account.avatar.attached?
      image_tag(
        account.avatar.variant(thumbnail: "#{size}x#{size}^", gravity: "center", extent: "#{size}x#{size}"),
        class: classes,
        alt: account.name
      )
    else
      content = content_tag(:span, account.name.to_s.first, class: "initials")

      if options[:include_user]
        content += image_tag(avatar_url_for(current_user), class: "avatar-small")
      end

      content_tag :span, content, class: "avatar bg-blue-500 #{classes}"
    end
  end

  def account_user_roles(account, account_user)
    roles = []
    roles << "Owner" if account_user.respond_to?(:user_id) && account.owner_id == account_user.user_id
    AccountUser::ROLES.each do |role|
      roles << role.to_s.humanize if account_user.public_send(:"#{role}?")
    end
    roles
  end

  def account_admin?(account, account_user)
    AccountUser.find_by(account: account, user: account_user).admin?
  end

  # A link to switch the account
  #
  # For session and path switching, we'll use a button_to and submit to the server
  # For subdomains, we can simply link to the subdomain
  # For domains, we can link to the domain (assuming it's configured correctly)
  def switch_account_button(account, **options)
    # if Jumpstart::Multitenancy.domain? && account.domain?
    #   link_to options.fetch(:label, account.name), account.domain, options
    if Jumpstart::Multitenancy.subdomain? && account.subdomain?
      link_to options.fetch(:label, account.name), root_url(subdomain: account.subdomain), options
    else
      button_to options.fetch(:label, account.name), switch_account_path(account), options.merge(method: :patch)
    end
  end
end
