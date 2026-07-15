class TreatmentType < ApplicationRecord
    enum :category, { eyebrow: 0, eyelash_perm: 1, nail: 2, hair: 3}
end