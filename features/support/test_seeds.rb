AfterConfiguration do |config|
  # Your code from seeds.rb
  CreatePlanService.new.call
  puts 'CREATED PLANS'

  $categories = {
      assicurazioni:{
          altro: ['casa', 'infortuni', 'auto', 'malattia', 'cyber_risk', 'protection indemnity'],
          vita:  ['mista', 'temporanea caso morte', 'vita intera', 'rendita', 'unit linked', 'pir', 'keyman']
      }
  }

  $categories.each do |key, value|
    level_1 = Category.find_or_create_by(name:key)
    if value.is_a?(Hash)
      value.each do |key2, val2|
        level_2 = Category.find_or_create_by(name:key2, parent: level_1)
        if val2.is_a?(Array)
          val2.each do |key3,val3|
            level_3 = Category.find_or_create_by(name:key3, parent: level_2)
          end
        end
      end
    end
  end
end

Before do
end

