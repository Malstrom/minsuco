class CreateServicesService
  def call
    s1 = Service.where(name: 'Highlight').first_or_initialize do |p|
      p.sppd = 1
    end
    s1.save!
  end
end