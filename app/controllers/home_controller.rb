class HomeController < ApplicationController

  def mosaic
    @display_type = :mosaic
    @photos = [{:src => "http://distilleryimage5.s3.amazonaws.com/fcfab19c38fb11e3ab1c22000aeb0d6e_6.jpg", :desc => "Bluegrass BBQ"}, {:src => "http://distilleryimage9.s3.amazonaws.com/5b38551838fa11e3b88d22000a1fd1dd_6.jpg", :desc => "Le Depanneur"}, {:src => "http://distilleryimage7.s3.amazonaws.com/86a2ba5438fa11e3b85022000a1f9e75_6.jpg", :desc => "Burger Club"}, {:src => "http://distilleryimage7.s3.amazonaws.com/5caa74f238fb11e3bdd322000ae90d23_6.jpg", :desc => "In-N-Out Burger"}, {:src => "http://distilleryimage11.s3.amazonaws.com/c293d44438fa11e38e5d22000a1f979a_6.jpg", :desc => "Smash Burger"}, {:src => "http://distilleryimage6.s3.amazonaws.com/80279a6438fa11e3b15c22000a9e06ef_6.jpg", :desc => "Shake Shack"}, {:src => "http://distilleryimage2.s3.amazonaws.com/01d9ca4638fb11e390de22000a1f97ef_6.jpg", :desc => "Skinners"}, {:src => "http://distilleryimage6.s3.amazonaws.com/ff773d8838fa11e3a2fe22000a1f8ce3_6.jpg", :desc => "Shake Shack"}, {:src => "http://distilleryimage8.s3.amazonaws.com/024e91b438fb11e3905922000ae9081c_6.jpg", :desc => "Hidden Valley Animal Adventure"}, {:src => "http://distilleryimage5.s3.amazonaws.com/86edcb8438fa11e3a57b22000aa800f2_6.jpg", :desc => "Independent Burger"}, {:src => "http://distilleryimage6.s3.amazonaws.com/9709588a38fa11e38de422000aeb0f93_6.jpg", :desc => "Kapelvej"}, {:src => "http://distilleryimage2.s3.amazonaws.com/3e630c1c38fa11e3ae2622000a1fb7e1_6.jpg", :desc => "VO"}, {:src => "http://distilleryimage6.s3.amazonaws.com/1c01cabe38fa11e384c322000a1fbca9_6.jpg", :desc => "Bon Burger"}, {:src => "http://distilleryimage7.s3.amazonaws.com/0d26346c38fa11e3a41422000a9e005f_6.jpg", :desc => "Sonic Drive-In"}, {:src => "http://distilleryimage11.s3.amazonaws.com/94414b9a38f911e39ddb22000aeb1105_6.jpg", :desc => "Oljebaren"}, {:src => "http://distilleryimage4.s3.amazonaws.com/d8b5886838f911e3a84922000a1f8c0f_6.jpg", :desc => "Five Guys"}, {:src => "http://distilleryimage5.s3.amazonaws.com/b01ea58038f711e3b6fb22000aeb121f_6.jpg", :desc => "Hamburgueria 162"}, {:src => "http://distilleryimage2.s3.amazonaws.com/8c269a3238f911e38e2d22000a1fbe71_6.jpg", :desc => "Humble Potato"}, {:src => "http://distilleryimage5.s3.amazonaws.com/b871946c38f811e3a96422000a1fbc12_6.jpg", :desc => "Smashburger"}, {:src => "http://distilleryimage8.s3.amazonaws.com/9f607e5238f811e3a9ce22000a9e02ef_6.jpg", :desc => "Avon"}, {:src => "http://distilleryimage3.s3.amazonaws.com/e383150038f711e3beb722000a9f3ce2_6.jpg", :desc => "Buzzbrews"}, {:src => "http://distilleryimage6.s3.amazonaws.com/959e67c638f811e380ad22000a1fbe2f_6.jpg", :desc => "The Apple Pan"}, {:src => "http://distilleryimage0.s3.amazonaws.com/6ea26fdc38f811e3893b22000aa8100d_6.jpg", :desc => "Izzy's Burger Spa"}, {:src => "http://distilleryimage0.s3.amazonaws.com/82b13cde38f711e3bd0222000a9e514f_6.jpg", :desc => "Grover's Bar & Grill"}, {:src => "http://distilleryimage8.s3.amazonaws.com/3322a04e38f811e38b4d22000ae911fb_6.jpg", :desc => "hans im gluck schwabing"}, {:src => "http://distilleryimage5.s3.amazonaws.com/feb10df038f711e3bb3922000aa81ffe_6.jpg", :desc => "Ozzie's Grill"}, {:src => "http://distilleryimage9.s3.amazonaws.com/5539d82438f711e3826122000a1fd1d7_6.jpg", :desc => "San Pedro Square Market"}, {:src => "http://distilleryimage0.s3.amazonaws.com/dd32275438f711e3a4b822000aaa04bd_6.jpg", :desc => "Place Ducale"}, {:src => "http://distilleryimage7.s3.amazonaws.com/69d26abc38f211e3a9de22000a1f92c9_6.jpg", :desc => "Naif sandwich&bar"}]
    render 'index'
  end

  def list
    @display_type = :list
    @places = [{:src => "http://distilleryimage5.s3.amazonaws.com/fcfab19c38fb11e3ab1c22000aeb0d6e_6.jpg", :desc => "Bluegrass BBQ"}, {:src => "http://distilleryimage9.s3.amazonaws.com/5b38551838fa11e3b88d22000a1fd1dd_6.jpg", :desc => "Le Depanneur"}, {:src => "http://distilleryimage7.s3.amazonaws.com/86a2ba5438fa11e3b85022000a1f9e75_6.jpg", :desc => "Burger Club"}, {:src => "http://distilleryimage7.s3.amazonaws.com/5caa74f238fb11e3bdd322000ae90d23_6.jpg", :desc => "In-N-Out Burger"}, {:src => "http://distilleryimage11.s3.amazonaws.com/c293d44438fa11e38e5d22000a1f979a_6.jpg", :desc => "Smash Burger"}, {:src => "http://distilleryimage6.s3.amazonaws.com/80279a6438fa11e3b15c22000a9e06ef_6.jpg", :desc => "Shake Shack"}, {:src => "http://distilleryimage2.s3.amazonaws.com/01d9ca4638fb11e390de22000a1f97ef_6.jpg", :desc => "Skinners"}, {:src => "http://distilleryimage6.s3.amazonaws.com/ff773d8838fa11e3a2fe22000a1f8ce3_6.jpg", :desc => "Shake Shack"}, {:src => "http://distilleryimage8.s3.amazonaws.com/024e91b438fb11e3905922000ae9081c_6.jpg", :desc => "Hidden Valley Animal Adventure"}, {:src => "http://distilleryimage5.s3.amazonaws.com/86edcb8438fa11e3a57b22000aa800f2_6.jpg", :desc => "Independent Burger"}, {:src => "http://distilleryimage6.s3.amazonaws.com/9709588a38fa11e38de422000aeb0f93_6.jpg", :desc => "Kapelvej"}, {:src => "http://distilleryimage2.s3.amazonaws.com/3e630c1c38fa11e3ae2622000a1fb7e1_6.jpg", :desc => "VO"}, {:src => "http://distilleryimage6.s3.amazonaws.com/1c01cabe38fa11e384c322000a1fbca9_6.jpg", :desc => "Bon Burger"}, {:src => "http://distilleryimage7.s3.amazonaws.com/0d26346c38fa11e3a41422000a9e005f_6.jpg", :desc => "Sonic Drive-In"}, {:src => "http://distilleryimage11.s3.amazonaws.com/94414b9a38f911e39ddb22000aeb1105_6.jpg", :desc => "Oljebaren"}, {:src => "http://distilleryimage4.s3.amazonaws.com/d8b5886838f911e3a84922000a1f8c0f_6.jpg", :desc => "Five Guys"}, {:src => "http://distilleryimage5.s3.amazonaws.com/b01ea58038f711e3b6fb22000aeb121f_6.jpg", :desc => "Hamburgueria 162"}, {:src => "http://distilleryimage2.s3.amazonaws.com/8c269a3238f911e38e2d22000a1fbe71_6.jpg", :desc => "Humble Potato"}, {:src => "http://distilleryimage5.s3.amazonaws.com/b871946c38f811e3a96422000a1fbc12_6.jpg", :desc => "Smashburger"}, {:src => "http://distilleryimage8.s3.amazonaws.com/9f607e5238f811e3a9ce22000a9e02ef_6.jpg", :desc => "Avon"}, {:src => "http://distilleryimage3.s3.amazonaws.com/e383150038f711e3beb722000a9f3ce2_6.jpg", :desc => "Buzzbrews"}, {:src => "http://distilleryimage6.s3.amazonaws.com/959e67c638f811e380ad22000a1fbe2f_6.jpg", :desc => "The Apple Pan"}, {:src => "http://distilleryimage0.s3.amazonaws.com/6ea26fdc38f811e3893b22000aa8100d_6.jpg", :desc => "Izzy's Burger Spa"}, {:src => "http://distilleryimage0.s3.amazonaws.com/82b13cde38f711e3bd0222000a9e514f_6.jpg", :desc => "Grover's Bar & Grill"}, {:src => "http://distilleryimage8.s3.amazonaws.com/3322a04e38f811e38b4d22000ae911fb_6.jpg", :desc => "hans im gluck schwabing"}, {:src => "http://distilleryimage5.s3.amazonaws.com/feb10df038f711e3bb3922000aa81ffe_6.jpg", :desc => "Ozzie's Grill"}, {:src => "http://distilleryimage9.s3.amazonaws.com/5539d82438f711e3826122000a1fd1d7_6.jpg", :desc => "San Pedro Square Market"}, {:src => "http://distilleryimage0.s3.amazonaws.com/dd32275438f711e3a4b822000aaa04bd_6.jpg", :desc => "Place Ducale"}, {:src => "http://distilleryimage7.s3.amazonaws.com/69d26abc38f211e3a9de22000a1f92c9_6.jpg", :desc => "Naif sandwich&bar"}]
    @places = @places.group_by { |p| p[:desc] }.to_a
    render 'index'
  end

  def map
    @map_data = Place.all.to_gmaps4rails
    @display_type = :map
    render 'index'
  end

  def place
    @place = {
      :name => 'Bluegrass BBQ',
      :likes => 10,
      :dislikes => 10,
      :photos => [{:src=>"http://distilleryimage1.s3.amazonaws.com/e01489b0397611e3a94522000a1fbc56_8.jpg", :author=>"alexaviiii", :desc=>"#grill'd #burger #chips #healthyburger", :link=>"http://instagram.com/p/fr9BWDyN1h/"}, {:src=>"http://distilleryimage6.s3.amazonaws.com/9dbf213cf4f411e1aaec22000a1e95c4_7.jpg", :author=>"cs_yap", :desc=>"#nasikunyit", :link=>"http://instagram.com/p/PEmloMBF02/"}]
    }
  end

  #helper_method :photos
  #def photos
  #  # cache for design purpose (until we implement everything properly)
  #  unless @photos
  #    @photos = InstagramFetcher.get_by_tag("burger", { :since => (Time.now - 5.hour) })
  #    @photos.delete_if { |photo| photo.location.nil? || photo.location.name.nil? }
  #    @photos.map! do |photo|
  #      {
  #        :src => photo.images.standard_resolution.url,
  #        :author => photo.user.username,
  #        :desc => photo.caption.text,
  #        :link => photo.link
  #      }
  #    end
  #  end
  #  @photos
  #end
end
