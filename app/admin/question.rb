ActiveAdmin.register Question do

  permit_params :title, :body, :slug, :image

  # filter :answers, label: "All Answers", collection: proc { Answer.all.map(&:body) }

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
