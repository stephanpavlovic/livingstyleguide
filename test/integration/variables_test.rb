require 'test_helper'
require 'fileutils'
require 'compass'
require 'compass/logger'
require 'sass/plugin'

class VariablesImporterTest < Minitest::Test

  def setup
    Compass.configure_sass_plugin!
  end

  def test_variables_outside_of_root_using_gemfile
    html = render('test/fixtures/standalone/variables/gemfile/styleguide/styleguide.html.lsg')
    assert_match %r(\.\\\$green), html
    refute_match %r(\.\\\$red), html
  end

  def test_variables_outside_of_root_using_git
    Dir.mkdir 'test/fixtures/standalone/variables/git/.git'
    html = render('test/fixtures/standalone/variables/git/styleguide/styleguide.html.lsg')
    assert_match %r(\.\\\$green), html
    refute_match %r(\.\\\$red), html
    Dir.rmdir 'test/fixtures/standalone/variables/git/.git'
  end

  private
  def render(file)
    Tilt.new(file).render.gsub(/\s+/, ' ')
  end

end

