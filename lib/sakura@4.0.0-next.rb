$:.unshift((Pathname.new(__FILE__).dirname/"..").realpath.to_s)

require "lib/config"

class SakuraAT400Next < Formula
  desc "GTK/VTE based terminal emulator."
  homepage "https://launchpad.net/sakura"
  license "GPL-2.0"

  stable do
    sakura_version = "HEAD-#{Config::commit}"
    url "https://github.com/dabisu/sakura/archive/#{Config::commit_long}.tar.gz"
    version sakura_version

    patch :p1, Formula["z80oolong/eaw/sakura"].diff_data
  end

  depends_on "gtk+3"
  depends_on "z80oolong/eaw/libvte@2.91"
  depends_on "systemd"
  depends_on "gettext"
  depends_on "pod2man" => :build
  depends_on "cmake" => :build

  keg_only :versioned_formula

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  def diff_data
    lines = self.path.each_line.inject([]) do |result, line|
      result.push(line) if ((/^__END__/ === line) || result.first)
      result
    end
    lines.shift
    return lines.join("")
  end

  test do
    system "#{bin}/sakura", "--version"
  end
end
