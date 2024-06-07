class WebpushNotification < ApplicationRecord
    belongs_to :user


  def publish(message)
      Webpush.payload_send(
        message: message,
        endpoint: endpoint,
        p256dh: p256dh_key,
        auth: auth_key,
        vapid: {
          public_key: 'BFW8VCewVHLvXq2DPWethWZMOwmN30ahPP7tFM34nY5w70ZlrOF1o5MvGCbdeolaQaFiyc0cp_nYaqdLKCMT2rI=',
          private_key: '_jiatFJaSAoXJGZ8ebPnZj5KffEaln696kl38pEjPHE='

          
        },
        )
    end
end
    

# public_key: ENV['VAPID_PUBLIC_KEY'],
# private_key: ENV['VAPID_PRIVATE_KEY']

        