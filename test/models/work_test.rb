require "test_helper"

describe Work do
  let(:work) { Work.new(title: ' Talking Rain', publication_year:1990, creator: 'tangering') }

  it "must be valid" do
    value(work).must_be :valid?
  end

  it 'has required fields' do
    fields = [:title, :publication_year, :creator]

    fields.each do |field|
      expect(work).must_respond_to field
    end
  end

  describe 'Relationships' do
    let(:work) { Work.new(title: ' Talking Rain', publication_year:1990, creator: 'tangering') }
    it 'can have many votes' do

      work.votes << Vote.first
      votes = work.votes

      expect(votes.length).must_be :>=, 1
      votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it 'can only be voted on by a unique user once' do
      # first_vote = Vote.first
      # second_vote = Vote.new(user_id:1, work_id:2)
    end

  end

  describe 'validations' do
    it 'must have a title' do
      # Arrange
      work = works(:harrypotter)
      work.title = nil
      work.save


      # Act
      valid = work.valid?


      # Assert
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it 'must have a publication_year with a 4 integers' do
      work.publication_year = 0
        # Arrange
        work.publication_year += 999

        # Act
        valid = work.valid?

        # Assert
        expect(valid).must_equal false
        expect(work.errors.messages).must_include :publication_year


      work.publication_year += 100
      valid = work.valid?
      expect(valid).must_equal true
    end

    it 'requires a unique title and category' do
      #other_book = book.clone
      poodr = works(:poodrbook)


      valid = poodr.valid?

      expect(valid).must_equal true

      poodr.category = 'movie'
      valid = poodr.valid?
      expect(valid).must_equal false
      expect(poodr.errors.messages).must_include :title
    end
  end


end
