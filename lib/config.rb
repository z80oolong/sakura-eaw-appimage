module Config
  module_function

  def stable_version?
    false
  end

  def current_vm_provider
    return "lxc"
    #return "libvirt"
  end

  def current_libvirt_driver
    return "qemu"
    #return "kvm"
  end

  def appimage_tap_name
    return "z80oolong/appimage"
  end

  def current_tap_name
    return "z80oolong/eaw"
  end

  def current_formula_name
    return "sakura"
  end

  def current_builder_name
    return "sakura-builder"
  end

  def current_appimage_name
    return "#{current_formula_name}-eaw"
  end

  def current_version_list
    if stable_version? then
      return ["3.8.6"]
    else
      return ["HEAD-#{commit}"]
    end
  end

  def all_stable_version
    return %w[3.8.4 3.8.5 3.8.6]
  end

  def current_head_formula_version
    return "4.0.0-next"
  end

  def all_stable_formulae
    return all_stable_version.map do |v|
      "#{Config::current_tap_name}/#{Config::current_formula_name}@#{v}"
    end
  end

  def current_head_formula
    return "#{lib_dir}/#{current_formula_name}@#{current_head_formula_version}.rb"
  end

  def commit_long
    return "2481747d777606c379c574f437517dc64e890667"
  end

  def commit
    return commit_long[0..7]
  end

  def current_appimage_revision
    return 52
  end

  def release_dir
    return "/vagrant/opt/releases"
  end

  def lib_dir
    return "/vagrant/lib"
  end

  def appimage_arch
    return "x86_64"
  end
end
