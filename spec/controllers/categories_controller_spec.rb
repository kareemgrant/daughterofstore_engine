require 'spec_helper'

describe CategoriesController do

  describe "GET 'show'" do
    let(:category){Category.create name:  "category"}
    let(:store){Store.create name:        "somename",
                             path:        "somepath",
                             description: "somedescription",
                             status:      "online"
                }

    it "assigns the requested category to category" do
      get :show, id: category, store_id: store
      expect(assigns(:category)).to eq category
    end

    it "renders the show template" do
      get :show, id: category, store_id: store
      expect(response).to render_template :show
    end

  end
end
