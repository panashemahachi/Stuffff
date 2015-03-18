json.array!(@invitations) do |invitation|
  json.extract! invitation, :id, :sender_id, :recipient_email, :token, :sent_at, :new
  json.url invitation_url(invitation, format: :json)
end
