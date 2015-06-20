class TransactionsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :index]
  before_action :correct_user,   only: [:new, :create, :index]
  
  def new
    @transaction = Transaction.new
    return @transaction
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.from_account_number = get_user_account_number
    if @transaction.save
      trans_amount = @transaction.amount
      my_money = get_cash
      Account.where(user_id: current_user.id).update_all(:cash => (my_money - trans_amount))
      target_money = Account.where(account_number: @transaction.to_account_number)
      
      Account.where(user_id: get_user_id_by_account_number(@transaction.to_account_number)).update_all(:cash => (get_cash_from_user(target_money)+trans_amount))
      flash[:success] = "Transaction completed!"
      redirect_to transactions_path
    else
      render 'new'
    end
  end

  def index
    query = "SELECT * FROM transactions WHERE from_account_number IN (SELECT account_number FROM accounts WHERE user_id = " \
    + current_user.id.to_s+") OR to_account_number IN (SELECT account_number FROM accounts WHERE user_id ="+current_user.id.to_s+") ;"
    #puts Transaction.where(from_account_number: Account.select("account_number").where(user_id: current_user.id)).or(to_account_number: Account.select("account_number").where(user_id: current_user.id))
    @transactions = ActiveRecord::Base.connection.execute(query) #Transaction.where(from_account_number: Account.select("account_number").where(user_id: current_user.id) )
    puts @transactions
  end

  
  private
  
    def transaction_params
      params.require(:transaction).permit(:from_account_number,:to_account_number, :created_at, :amount)
    end
  
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    def correct_user
      @user = current_user
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
    def get_user_account_number
      user = current_user
      account = Account.where(user_id: @user.id)
      account.each do |record|  
        number = record.account_number
        return number
      end
    end
    
    def get_user_id_by_account_number(number)
      id = Account.where(account_number: number)
      id.each do |record|  
        record = record.user_id
        return record
      end
    end
    
    def get_cash
      cash = Account.where(user_id: current_user.id)
      cash.each do |record|  
        record = record.cash
        return record
      end
    end
    
    def get_cash_from_user(account)
      account.each do |record|  
        record = record.cash
        return record
      end
    end
end
