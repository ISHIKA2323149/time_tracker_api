require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  # Define valid attributes for user creation
  let(:valid_attributes) {
    { name: 'John Doe' }
  }

  # Define invalid attributes for user creation
  let(:invalid_attributes) {
    { name: nil }
  }

  # Define a valid user for testing
  let(:valid_user) {
    User.create(valid_attributes)
  }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns the correct user" do
      get :show, params: { id: valid_user.to_param }
      expect(assigns(:user)).to eq(valid_user)
    end

    it "returns a 404 status for an invalid user" do
      get :show, params: { id: 999 } # Assuming 999 is an invalid user ID
      expect(response).to have_http_status(404)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "returns a JSON response with the new user" do
        post :create, params: { user: valid_attributes }
        expect(response).to have_http_status(201)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post :create, params: { user: invalid_attributes }
        }.to_not change(User, :count)
      end

      it "returns a 422 status for invalid attributes" do
        post :create, params: { user: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PUT #update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: 'Updated Name' }
      }

      it "updates the requested user" do
        put :update, params: { id: valid_user.to_param, user: new_attributes }
        valid_user.reload
        expect(valid_user.name).to eq('Updated Name')
      end

      it "returns a JSON response with the updated user" do
        put :update, params: { id: valid_user.to_param, user: valid_attributes }
        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid parameters" do
      it "returns a 422 status for invalid attributes" do
        put :update, params: { id: valid_user.to_param, user: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end

    it "returns a 404 status for an invalid user" do
      put :update, params: { id: 999, user: valid_attributes } # Assuming 999 is an invalid user ID
      expect(response).to have_http_status(404)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      valid_user # Create a valid user
      expect {
        delete :destroy, params: { id: valid_user.to_param }
      }.to change(User, :count).by(-1)
    end

    it "returns a 204 status after destroying the user" do
      delete :destroy, params: { id: valid_user.to_param }
      expect(response).to have_http_status(204)
    end

    it "returns a 404 status for an invalid user" do
      delete :destroy, params: { id: 999 } # Assuming 999 is an invalid user ID
      expect(response).to have_http_status(404)
    end
  end
end
