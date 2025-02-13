module SeedData
  @seeders = []

  def self.register(seeder)
    @seeders << seeder
  end

  def self.seed_all
    @seeders.each do |seeder|
      if seeder.respond_to?(:seed)
        puts "Seeding: #{seeder}"
        seeder.seed
      end
    end
  end
end
