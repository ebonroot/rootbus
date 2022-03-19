defmodule Rootbus.Test.Factory.Bank do
  use Rootbus.Context

  defmacro __using__(_opts) do
    quote location: :keep do
      def bank_account_factory do
        %Db.BankAccount{
          player: build(:player),
          # shop: build(:shop),
          # land: build(:land),
          name: Faker.Pizza.cheese(),
          type: :player,
          balance: 2000.11
        }
      end

      def bank_ledger_factory do
        %Db.BankLedger{
          player: build(:player),
          account: build(:bank_account),
          amount: 345.54,
          memo: Faker.Pizza.meat()
        }
      end
    end
  end
end
