module FlashHelper
  def class_for_flash(name)
    flash_classes = {
      'success' => 'alert alert-success',
      'error' => 'alert alert-danger',
      'notice' => 'alert alert-info',
      'alert' => 'alert alert-warning'
    }
    flash_classes[name] || 'alert-secondary'
  end
end
