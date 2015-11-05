module UpdateTracking
    def track_update(model)
      model.updates.create(user: current_user)
    end
end
