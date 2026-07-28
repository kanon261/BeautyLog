TreatmentType.find_or_create_by(category: "eyebrow") do |treatment_type|
  treatment_type.standard_cycle_days = 31
end

TreatmentType.find_or_create_by(category: "eyelash_perm") do |treatment_type|
  treatment_type.standard_cycle_days = 40
end

TreatmentType.find_or_create_by(category: "nail") do |treatment_type|
  treatment_type.standard_cycle_days = 32
end

TreatmentType.find_or_create_by(category: "hair") do |treatment_type|
  treatment_type.standard_cycle_days = 60
end