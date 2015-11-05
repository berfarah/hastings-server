RSpec.shared_context "an updatable model" do |model|
  it "tracks the update" do
    m = create(model)
    new_attr = attributes_for(model)
    put :update, {:id => m.to_param, model => new_attr}, valid_session
    expect(Update.where(updatable_id: m.id, updatable_type: model.capitalize)).not_to be_empty
  end
end
