RSpec.describe ApplicationHelper do
  describe '#riot_image_link' do
    def link(name)
      "http://ddragon.leagueoflegends.com/cdn/5.7.1/img/champion/#{name}.png"
    end

    describe 'special names' do
      { "Kog'Maw": 'KogMaw', "Kha'Zix": 'Khazix', "Cho'Gath": 'Chogath',
        "Vel'Koz": 'Velkoz', 'Dr.Mundo': 'DrMundo', 'LeBlanc': 'Leblanc',
        'Fiddlesticks': 'FiddleSticks',
        'Wukong': 'MonkeyKing' }.each do |key, value|
        describe "#{key}" do
          it "returns #{value}" do
            expect(riot_image_link(key.to_s)).to eq link value
          end
        end
      end
    end

    describe 'regular names' do
      %w(Sona Teemo Amumu).each do |name|
        describe "#{name}" do
          it "returns #{name}" do
            expect(riot_image_link(name)).to eq link name
          end
        end
      end
    end
  end

  describe '#riot_splash_link' do
    def link(name)
      "http://ddragon.leagueoflegends.com/cdn/img/champion/splash/#{name}_0.jpg"
    end

    describe 'special names' do
      { "Kog'Maw": 'KogMaw', "Kha'Zix": 'Khazix', "Cho'Gath": 'Chogath',
        "Vel'Koz": 'Velkoz', 'Dr.Mundo': 'DrMundo', 'LeBlanc': 'Leblanc',
        'Fiddlesticks': 'FiddleSticks',
        'Wukong': 'MonkeyKing' }.each do |key, value|
        describe "#{key}" do
          it "returns #{value}" do
            expect(riot_splash_link(key.to_s)).to eq link value
          end
        end
      end
    end

    describe 'regular names' do
      %w(Sona Teemo Amumu).each do |name|
        describe "#{name}" do
          it "returns #{name}" do
            expect(riot_splash_link(name)).to eq link name
          end
        end
      end
    end
  end

  describe '#riot_role_link' do
    def link(id)
      "http://ddragon.leagueoflegends.com/cdn/5.7.1/img/profileicon/#{id}.png"
    end

    { 'Assassin' => 657, 'Fighter'  => 658,
      'Mage'     => 659, 'Marksman' => 660,
      'Support'  => 661, 'Tank'     => 662 }.each do |name, id|
      describe "#{name}" do
        it 'returns the right link' do
          expect(riot_role_link(name)).to eq link id
        end
      end
    end
  end

  describe '#button_is_active?' do
    context 'order_param is nil' do
      context 'value matches default' do
        it 'returns true' do
          expect(button_is_active?('win_rate')).to be_truthy
        end
      end

      context 'value does not match default' do
        it 'returns false' do
          expect(button_is_active?('cats')).to be_falsey
        end
      end
    end
    context 'order param is not nil' do
      context 'value matches order_param' do
        it 'returns true' do
          expect(button_is_active?('pick_rate', 'pick_rate')).to be_truthy
        end
      end

      context 'value does not match order_param' do
        it 'returns false' do
          expect(button_is_active?('cats', 'pick_rate')).to be_falsey
        end
      end
    end
  end

  describe '#button_active_class' do
    context 'is active' do
      it 'returns the active class' do
        expect(button_active_class(true)).to eq 'active'
      end
    end

    context 'is not active' do
      it 'returns empty string' do
        expect(button_active_class(false)).to eq ''
      end
    end
  end

  describe '#button_glyph_class' do
    context 'is active' do
      context 'ascending' do
        it 'returns the up icon class' do
          expect(button_glyph_class(true, 'true')).to eq 'caret-up'
        end
      end

      context 'descending' do
        it 'returns the down icon class' do
          expect(button_glyph_class(true, 'false')).to eq 'caret-down'
        end
      end

      context 'no ascending param' do
        it 'returns the down icon class' do
          expect(button_glyph_class(true)).to eq 'caret-down'
        end
      end
    end

    context 'is not active' do
      context 'ascending' do
        it 'returns empty string' do
          expect(button_glyph_class(false, 'true')).to eq ''
        end
      end

      context 'descending' do
        it 'returns empty string' do
          expect(button_glyph_class(false, 'false')).to eq ''
        end
      end

      context 'no ascending param' do
        it 'returns empty string' do
          expect(button_glyph_class(false)).to eq ''
        end
      end
    end
  end

  describe '#normalize_average_rate' do
    it 'normalizes the rate' do
      expect(normalize_average_rate(1.23, 4.56)).to eq -73.03
    end
  end

  describe '#round_rate' do
    it 'rounds by default to 2 places' do
      expect(round_rate(12.345678)).to eq 12.35
    end

    it 'accepts a decimal param' do
      expect(round_rate(12.345678, 4)).to eq 12.3457
    end
  end

  describe '#rate_class' do
    context 'rate below 0' do
      it 'returns below-average' do
        expect(rate_class(-0.234)).to eq 'below-average'
      end
    end

    context 'rate at 0' do
      it 'returns above-average' do
        expect(rate_class(0)).to eq 'above-average'
      end
    end

    context 'rate above 0' do
      it 'returns above-average' do
        expect(rate_class(0.345)).to eq 'above-average'
      end
    end
  end

  describe '#rate_glyph_class' do
    context 'rate below 0' do
      it 'returns arrow-down' do
        expect(rate_glyph_class(-0.12)).to eq 'arrow-down'
      end
    end

    context 'rate at 0' do
      it 'returns arrow-up' do
        expect(rate_glyph_class(0)).to eq 'arrow-up'
      end
    end

    context 'rate above 0' do
      it 'returns arrow-up' do
        expect(rate_glyph_class(0.12)).to eq 'arrow-up'
      end
    end
  end

  describe '#rate_tooltip' do
    context 'rate below 0' do
      it 'returns below average' do
        expect(rate_tooltip(-0.12)).
          to eq I18n.t('champions.tooltips.below_avg')
      end
    end

    context 'rate at 0' do
      it 'returns above average' do
        expect(rate_tooltip(0)).
          to eq I18n.t('champions.tooltips.above_avg')
      end
    end

    context 'rate above 0' do
      it 'returns above average' do
        expect(rate_tooltip(0.12)).
          to eq I18n.t('champions.tooltips.above_avg')
      end
    end
  end

  describe '#index_subtitle' do
    context 'roles' do
      it 'pluralizes the role' do
        expect(index_subtitle(role: 'rawr')).to eq 'rawrs'
      end
    end

    context 'rated' do
      it 'displayed capitalized rated champions text' do
        expect(index_subtitle(rated: 'over')).
          to eq I18n.t('champions.index.rated_champions_subtitle',
                       rated: 'over').capitalize << ' - ' <<
            I18n.t('champions.index.over')
      end
    end

    context 'default' do
      it 'returns the default subtitle' do
        expect(index_subtitle(rawr: 'rawr')).
          to eq I18n.t('champions.index.subtitle')
      end
    end
  end

  describe '#kda_image' do
    describe 'kills' do
      it 'returns an image link to riot swords' do
        image = image_tag(
          'http://ddragon.leagueoflegends.com/cdn/5.2.1/img/ui/score.png'
        )
        expect(kda_image('kills')).to eq image
      end
    end

    describe 'deaths' do
      it 'returns the html entity for the crossbones' do
        expect(kda_image('deaths')).to eq raw '&#9760;'
      end
    end

    describe 'assists' do
      it 'returns assist.png image' do
        expect(kda_image('assists')).to eq image_tag 'assist.png'
      end
    end

    describe 'other input' do
      it 'returns nil' do
        expect(kda_image('rawr')).to eq nil
      end
    end
  end

  describe '#cachebuster' do
    it 'returns the cachebuster' do
      ENV['CACHE_COUNTER'] = 'I am a cache'
      expect(cachebuster).to eq ENV['CACHE_COUNTER']
    end
  end

  describe '#tooltip_helper' do
    let(:title)  { 'rawr' }
    let(:tag)    { :li }
    let(:_class) { '' }
    let(:result) do
      tooltip_helper(title: title, class_name: _class, tag_type: tag) do
        haml_tag(:div)
      end
    end

    def expected(title:, _class: '', tag: :li)
      tag = tag.to_s
      "<#{tag} class='#{_class}' data-toggle='tooltip' title='#{title}'>\n  "\
      "<div></div>\n</#{tag}>\n"
    end

    describe 'default' do
      it 'returns the default tag with a tooltip' do
        expect(result).to eq expected(title: title)
      end
    end

    describe 'tag option' do
      let(:tag) { :div }

      it 'returns the passed tag with a tooltip' do
        expect(result).to eq expected(title: title, tag: tag)
      end
    end

    describe 'class option' do
      let(:_class) { 'active' }

      it 'returns the tag with a tooltip and class' do
        expect(result).to eq expected(title: title, _class: _class)
      end
    end

    context 'td tag' do
      let(:tag) { :td }

      it 'surrounds the content in a div' do
        expect(result).to eq(
          "<td class=''>\n  <span data-toggle='tooltip' title='#{title}'>\n"\
          "    <div></div>\n  </span>\n</td>\n"
        )
      end
    end
  end
end
