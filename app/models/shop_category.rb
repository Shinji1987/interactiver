class ShopCategory < ActiveHash::Base
  self.data = [
    { :id => 1, :name => '--' },
    { :id => 2, :name => '居酒屋' },
    { :id => 3, :name => '和食店' },
    { :id => 4, :name => '寿司' },
    { :id => 5, :name => '焼肉屋' },
    { :id => 6, :name => 'イタリアンレストラン・フレンチレストラン' },
    { :id => 7, :name => 'カレー屋' },
    { :id => 8, :name => '中華料理店' },
    { :id => 9, :name => '洋食屋・西洋料理レストラン' },
    { :id => 10, :name => '鍋料理店' },
    { :id => 11, :name => 'アジア・エスニック料理店' },
    { :id => 12, :name => 'ラーメン屋' },
    { :id => 13, :name => 'バー・バル・ダイニングバー' },
    { :id => 14, :name => 'カフェ・スイーツの店' },
    { :id => 15, :name => '宴会・カラオケ・エンターテイメント' },
    { :id => 16, :name => 'その他の料理の店' }
  ]

  include ActiveHash::Associations
  has_many :shops

end