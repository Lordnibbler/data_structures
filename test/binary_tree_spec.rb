require 'rspec'
require './binary_tree'

include BinaryTree

describe Node do
  share_examples_for 'Node with word "foo"' do
    its(:value)  { should == 'foo' }
  end

  share_examples_for 'Node with one child with no children' do
    its(:size) { should == 2 }
  end

  share_examples_for 'Node with two children with no children' do
    its(:size) { should == 3 }
  end

  share_examples_for 'Node with no children' do
    its(:left)  { should be_nil }
    its(:right) { should be_nil }
  end

  context 'with word "foo" and no children' do
    subject { Node.new('foo') }

    it_should_behave_like 'Node with word "foo"'
    it_should_behave_like 'Node with no children'

    its(:size)  { should == 1 }
    its(:count) { should == 1 }
    its(:values) { should == ['foo'] }
    its(:count_all) { should == 1 }
  end

  context 'with word "foo" and inserted a node with word "bar"' do
    before do
      @node = Node.new('foo')
      @node.insert(Node.new('bar'))
    end

    subject { @node }

    it_should_behave_like 'Node with word "foo"'
    it_should_behave_like 'Node with one child with no children'

    its(:right) { should be_nil }
    its(:values) { should == ['bar', 'foo'] }
    its(:count_all) { should == 2 }

    describe 'its child on the left' do
      subject { @node.left }

      it_should_behave_like 'Node with no children'

      its(:value)  { should == 'bar' }
      its(:size)  { should == 1 }
      its(:count) { should == 1 }
      its(:count_all) { should == 1 }
    end
  end

  context 'with word "foo" and inserted a node with word "hoge"' do
    before do
      @node = Node.new('foo')
      @node.insert(Node.new('hoge'))
    end

    subject { @node }

    it_should_behave_like 'Node with word "foo"'
    it_should_behave_like 'Node with one child with no children'

    its(:left)  { should be_nil }
    its(:values) { should == ['foo', 'hoge'] }
    its(:count_all) { should == 2 }

    describe 'its child on the right' do
      subject { @node.right }

      it_should_behave_like 'Node with no children'

      its(:value)  { should == 'hoge' }
      its(:size)  { should == 1 }
      its(:count) { should == 1 }
      its(:count_all) { should == 1 }
    end
  end

  context 'with word "foo" and inserted a node with word "foo"' do
    subject do
      node = Node.new('foo')
      node.insert(Node.new('foo'))
      node
    end

    it_should_behave_like 'Node with word "foo"'
    it_should_behave_like 'Node with no children'

    its(:count) { should == 2 }
    its(:values) { should == ['foo'] }
    its(:count_all) { should == 2 }
  end

  context 'with word "foo" and inserted a node with word "bar" 3 times' do
    before do
      @node = Node.new('foo')
      3.times { @node.insert(Node.new('bar')) }
    end

    subject { @node }

    it_should_behave_like 'Node with word "foo"'

    its(:right) { should be_nil }
    its(:count) { should == 1 }
    its(:size)  { should == 2 }
    its(:values) { should == ['bar', 'foo'] }
    its(:count_all) { should == 4 }

    describe 'its child on the left' do
      subject { @node.left }

      its(:value)  { should == 'bar' }
      its(:size)  { should == 1 }
      its(:count) { should == 3 }
      its(:count_all) { should == 3 }
    end
  end

  context 'with word "foo" and inserted a node with word "hoge" 3 times' do
    before do
      @node = Node.new('foo')
      3.times { @node.insert(Node.new('hoge')) }
    end

    subject { @node }

    it_should_behave_like 'Node with word "foo"'

    its(:left)  { should be_nil }
    its(:count) { should == 1 }
    its(:size)  { should == 2 }
    its(:values) { should == ['foo', 'hoge'] }
    its(:count_all) { should == 4 }

    describe 'its child on the right' do
      subject { @node.right }

      its(:value)  { should == 'hoge' }
      its(:size)  { should == 1 }
      its(:count) { should == 3 }
      its(:count_all) { should == 3 }
    end
  end

  context 'with word "a" and inserted nodes with word "b" ~ "j"' do
    before do
      @node = Node.new('a')
      %w{b c d e f g h i j}.each do |word|
        @node.insert(Node.new(word))
      end
    end

    subject { @node }

    its(:size)  { should == 10 }
    its(:values) { should == %w{a b c d e f g h i j} }
  end
end
