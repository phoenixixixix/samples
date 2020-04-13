# frozen_string_literal: true

RSpec.shared_examples 'paginated collection response' do
  it 'returns only 20 posts from 1 page' do
    get @request_path

    posts = parsed_response_body[:collection][:data]
    expect(posts.size).to eq(20)
  end

  it 'returns only requested number of posts per page' do
    get @request_path, params: { per_page: 13 }

    posts = parsed_response_body[:collection][:data]
    expect(posts.size).to eq(13)
  end

  it 'returns max 100 posts per page' do
    get @request_path, params: { per_page: 1000 }

    posts = parsed_response_body[:collection][:data]
    expect(posts.size).to eq(100)
  end

  it 'returns number of total pages' do
    get @request_path

    expected_total_pages = (@total_records / @per_page.to_f).ceil
    expect(parsed_response_body[:collection][:total_pages]).to eq(expected_total_pages)
  end

  it 'returns current page' do
    get @request_path, params: { page: 5 }

    expect(parsed_response_body[:collection][:current_page]).to eq(5)
  end
end
