# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula

class Scimax < Formula
  desc "Awesome editing for scientists and engineers."
  homepage "https://github.com/jkitchin/scimax"
#  url "https://github.com/jkitchin/scimax/archive/refs/heads/master.zip"
  version "3.0"
  sha256 ""
  license "CC-BY-SA-4.0"

  #
  # Options
  option "with-emacs", "build with emacs"
  option "with-latex", "build with texlive"
  option "with-anaconda", "build with anaconda"

  #
  # dependencies
  head do
    url "https://github.com/jkitchin/scimax.git", branch: "master"
  end
  
  depends_on "cask"
  depends_on "coreutils"
  depends_on "git"
  depends_on "grep"
  depends_on "the_silver_searcher"
  depends_on "aspell"
  depends_on "enchant"
  depends_on "tesseract"
  depends_on "sqlite"

  # this is a cask, not sure it is possible here.
  # https://github.com/orgs/Homebrew/discussions/3163
  # depends_on "wkhtmltopdf"   

  # Unclear how to add options here, e.g. imagemagick, etc.
  if build.with? "emacs"
    depends_on "d12frosted/homebrew-emacs-plus/emacs-plus@28"
  end

  if build.with? "latex"
    depends_on "texlive"
  end

  if build.with? "anaconda"
    depends_on "anaconda"
  end  


  def install
    # this goes in /usr/local/Cellar/scimax/3.0/bin/scimax
    # It is already executable
    (bin/"scimax").write <<~EOS
      #!/bin/bash
      /usr/local/bin/emacs -q -l #{elisp}/init.el $@
    EOS

    # This seems to copy scimax files to this location
    # whoa.. this goes in /usr/local/Cellar/scimax/3.0/share/emacs/site-lisp/scimax
    # elisp.install Pathname.glob("*")
    system "git", "clone", "https://github.com/jkitchin/scimax.git", "#{elisp}"
    # this should pull packages from ELPA, MELPA, etc.
    system "emacs", "--batch", "-q", "-l", "#{elisp}/init.el"
  end

  def caveats
    <<~EOS
    Congratulations, you have installed scimax!

    Get started by running scimax in a terminal.
    EOS
  end

  test do
    #  Run the test with `brew test scimax`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "emacs", "--batch", "-q", "-l", "#{elisp}/init.el"
  end
end
