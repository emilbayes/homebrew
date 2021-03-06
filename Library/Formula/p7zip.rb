class P7zip < Formula
  desc "7-Zip (high compression file archiver) implementation"
  homepage "http://p7zip.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/p7zip/p7zip/9.20.1/p7zip_9.20.1_src_all.tar.bz2"
  sha256 "49557e7ffca08100f9fc687f4dfc5aea703ca207640c76d9dee7b66f03cb4782"

  bottle do
    cellar :any_skip_relocation
    revision 2
    sha256 "ca8c3e999af9b2dcd7ba4889c94111b0ab8971eb4234f4935a5d0d644ec755d8" => :el_capitan
    sha256 "d92cf7a481836bfc5b2292d636d45333b1946b82835510329eb0aa17483978ed" => :yosemite
    sha256 "c621e245f8b0912e135861756e3b3f443858f3d8291887d2438acbf3c09f4ee3" => :mavericks
  end

  devel do
    url "https://downloads.sourceforge.net/project/p7zip/p7zip/9.38.1/p7zip_9.38.1_src_all.tar.bz2"
    sha256 "fd5019109c9a1bf34ad3257d37a6853eae8151ff50345f0a3ffba7d8c5fdb995"
  end

  option "32-bit"

  def install
    if Hardware.is_32_bit? || build.build_32_bit?
      mv "makefile.macosx_32bits", "makefile.machine"
    else
      mv "makefile.macosx_64bits", "makefile.machine"
    end

    # install.sh chmods to 444, which is bad and breaks uninstalling
    inreplace "install.sh", /chmod (444|555).*/, ""

    system "make", "all3",
                   "CC=#{ENV.cc} $(ALLFLAGS)",
                   "CXX=#{ENV.cxx} $(ALLFLAGS)"
    system "make", "DEST_HOME=#{prefix}",
                   "DEST_MAN=#{man}",
                   "install"
  end
end
