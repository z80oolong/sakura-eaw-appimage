class SakuraBuilder < AppImage::Builder
  # For brew appimage-build
  def apprun; <<~EOS
    #!/bin/sh
    #export APPDIR="/tmp/.mount-sakuXXXXXX"
    if [ "x${APPDIR}" = "x" ]; then
      export APPDIR="$(dirname "$(readlink -f "${0}")")"
    fi

    if [ "x${HOMEBREW_PREFIX}" = "x" ]; then
      export PATH="${APPDIR}/usr/bin/:${HOMEBREW_PREFIX}/bin/:${PATH:+:$PATH}"
      export XDG_DATA_DIRS="${APPDIR}/usr/share/:${HOMEBREW_PREFIX}/share/:${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}"
    else
      export PATH="${APPDIR}/usr/bin/:${PATH:+:$PATH}"
      export XDG_DATA_DIRS="${APPDIR}/usr/share/:${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}"
    fi

    export LOCALEDIR="${APPDIR}/usr/share/locale"
    unset ARGV0

    export LDSO="${APPDIR}/usr/bin/ld.so"
    export SAKURA="${APPDIR}/usr/bin/sakura"

    if [ -x ${LDSO} ]; then
      exec "${LDSO}" "${SAKURA}" "$@"
    else
      exec "${SAKURA}" "$@"
    fi
    EOS
  end

  def exec_path_list
    return [opt_bin/"sakura"]
  end

  def pre_build_appimage(appdir, verbose)
    system("cp -pRv #{Formula[full_name].opt_share}/locale #{appdir.share}")
    system("cp -pRv #{Formula[full_name].opt_share}/applications #{appdir.share}")
    system("cp -pRv #{Formula[full_name].opt_share}/pixmaps #{appdir.share}")
    system("rm -v #{appdir}/sakura.desktop #{appdir}/#{name}.png")
    appdir.icons_scalable.install_symlink(appdir.share/"pixmaps/terminal-tango.svg")
    appdir.install_symlink(appdir.share/"pixmaps/terminal-tango.svg")
    appdir.install_symlink(appdir.share/"applications/sakura.desktop")
  end
end
