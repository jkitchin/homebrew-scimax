# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula

class Scimax < Formula
  desc "Awesome editing for scientists and engineers."
  homepage "https://github.com/jkitchin/scimax"
  url "https://github.com/jkitchin/scimax/archive/refs/heads/homebrew.zip"
  version "3.0"
  sha256 ""
  license "CC-BY-SA-4.0"

  #
  # Options
  # option "with-emacs", "build with emacs"
  # option "with-latex", "build with texlive"
  # option "with-anaconda", "build with anaconda"

  #
  head do
    url "https://github.com/jkitchin/scimax.git", branch: "homebrew"
  end
  
  depends_on "cask"
  depends_on "coreutils"
  depends_on "git"
  depends_on "grep"
  depends_on "the_silver_searcher"
  depends_on "aspell"
  depends_on "enchant"
  depends_on "typos-cli"
  depends_on "tesseract"
  depends_on "sqlite"

  def install
    # this goes in /usr/local/Cellar/scimax/<version>/bin/scimax
    # It is already executable
    (bin/"scimax").write <<~EOS
      #!/bin/bash
      emacs $@ &
    EOS

    # This seems to copy scimax files to this location
    # whoa.. this goes in /usr/local/Cellar/scimax/<version>/share/emacs/site-lisp/scimax
    elisp.install Pathname.glob("*")

    # should I byte-compile?
    # This doesn't seem to byte-compile the right thing
    # The lisp ends up in "/usr/local/opt/scimax/share/emacs/site-lisp/scimax/ and these are not byte-compiled from this
    # system "emacs", "-batch", "-f", "batch-byte-compile" "#{elisp}/**.el"
    
    # this should pull packages from ELPA, MELPA, etc.
    system "emacs", "--batch", "-l", "#{elisp}/init.el"
  end

  def caveats
    <<~EOS
    Congratulations, you have installed scimax!

    You are almost done. You should add this line to your ~/.emacs.d/init.el
    file. It should be one of the first things that is run in the file, and
    before any of your code gets run.

    (load "#{elisp}/init.el")

    Get started by running emacs in a terminal.
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
