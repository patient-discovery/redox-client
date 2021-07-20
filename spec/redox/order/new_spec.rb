# frozen_string_literal: true

RSpec.describe Redox::Order::New do
  it "supports Redox JSON" do
    json = IO.read "spec/data/order-new/order-new--redox-sample.json"

    order = Redox::Order::New.from_redox_json json

    expect(order.meta.data_model).to eq "Order"
    expect(order.meta.event_type).to eq "New"
  end

  it "provides access to key fields" do
    json = IO.read "spec/data/order-new/order-new--with-patient-email.json"

    order = Redox::Order::New.from_redox_json json

    expect(order.meta.data_model).to eq "Order"
    expect(order.meta.event_type).to eq "New"
    expect(order.order.id).to eq "123456789"
    expect(order.patient.identifiers.first.id).to eq "9876543210"
    expect(order.patient.demographics.email_addresses).to eq ["tim.bixby@example.net"]
  end
end
