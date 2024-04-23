module WalkHelpers
  def create_arrivals(walk, number)
    number.times do
      if walk.arrivals.empty?
        FactoryBot.create(:arrival, walk:, station_id: 1)
      else
        next_station = walk.current_station.next(clockwise: walk.clockwise)
        FactoryBot.create(:arrival, walk:, station: next_station)
      end
    end
  end

  def start_walk
    visit new_walk_path
    click_on 'はじめる'
    expect(page).to have_content('歩行記録の作成に成功しました')
  end

  def start_counter_clockwise_walk
    visit new_walk_path
    choose '内回り'
    click_on 'はじめる'
    expect(page).to have_content('歩行記録の作成に成功しました')
  end
end
