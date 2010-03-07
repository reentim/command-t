# Copyright 2010 Wincent Colaiuta. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper')

describe CommandT::Scanner::Ruby do
  before do
    @dir = File.join(File.dirname(__FILE__), '..', '..', '..', 'fixtures')
    @scanner = CommandT::Scanner::Ruby.new @dir
  end

  describe 'paths method' do
    it 'should return a list of regular files' do
      @scanner.paths.should == ['bar/abc', 'bar/xyz', 'baz', 'bing',
        'foo/alpha/t1', 'foo/alpha/t2', 'foo/beta']
    end
  end

  describe 'flush method' do
    it 'should force a rescan on next call to paths method' do
      first = @scanner.paths
      @scanner.flush
      @scanner.paths.object_id.should_not == first.object_id
    end
  end

  describe 'path= method' do
    it 'should allow repeated applications of scanner at different paths' do
      @scanner.paths.should == ['bar/abc', 'bar/xyz', 'baz', 'bing',
        'foo/alpha/t1', 'foo/alpha/t2', 'foo/beta']

      # drill down 1 level
      @scanner.path = File.join(@dir, 'foo')
      @scanner.paths.should == ['alpha/t1', 'alpha/t2', 'beta']

      # and another
      @scanner.path = File.join(@dir, 'foo', 'alpha')
      @scanner.paths.should == ['t1', 't2']
    end
  end
end
