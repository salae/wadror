class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
    # poistetaan klubit johon kirjautunut jo kuuluu, karkea ratkaisu mutta pitäisi toimia
    cu_clubs = current_user.beer_clubs
    exclude_ids = cu_clubs.map {|c| c.id}
    @clubs = BeerClub.all.where.not(id: exclude_ids)
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships.json
  def create
    @membership = Membership.new params.require(:membership).permit(:beer_club_id)
    
    respond_to do |format|
      if @membership.save
        current_user.memberships << @membership
        format.html { redirect_to user_path current_user, notice: 'Membership was successfully created.' }
        format.json { render :show, status: :created, location: @membership }
      else
        # poistetaan klubit johon kirjautunut jo kuuluu, karkea ratkaisu mutta pitäisi toimia
        cu_clubs = current_user.beer_clubs
        exclude_ids = cu_clubs.map {|c| c.id}
        @clubs = BeerClub.all.where.not(id: exclude_ids)       
        # @clubs = BeerClub.all
        format.html { render :new }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to memberships_url, notice: 'Membership was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:beer_club_id, :user_id)
    end
end
