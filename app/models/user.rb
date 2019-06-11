# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  name                   :string
#  surname                :string
#  is_active              :boolean          default(TRUE)
#  time_zone              :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#


class User < ApplicationRecord
  include PasswordCreatable

  # Scopes
  scope :active, -> { where(is_active: true) }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  # Send devise emails with background job
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  # Helpers
  audited except: [:password]

  # Validations
  validates_presence_of :name, :email, :surname
  validates :email, uniqueness: true

  def active_for_authentication?
    super && is_active
  end

  def full_name
    "#{name} #{surname}"
  end

  private

  def login_info_mailer
    UserMailer
  end
end
